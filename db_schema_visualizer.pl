#!/usr/bin/perl
# db_schema_visualizer.pl
# See: https://joelonsql.com/2016/12/10/pg_catalog-visualized
#
# db_schema_visualizer.pl > pg_catalog.dot
# dot -Tpng -o pg_catalog.png pg_catalog.dot


use strict;
use warnings;

use File::Slurp qw(slurp);
use Data::Dumper;

open my $fh, "<:encoding(utf8)", './doc/src/sgml/catalogs.sgml' or die "$!";

my $table;
my $column;
my $references;
my $pg_catalog_fk_map = {};

while (my $line = <$fh>) {
    chomp $line;
    if ($line =~ m!^\s+<title><structname>([^<>]+)</> Columns</title>$!) {
        $table = $1;
    } elsif ($line =~ m!^\s+<entry><structfield>([^<>]+)</structfield></entry>$!) {
        $column = $1;
    } elsif ($line =~ m!^\s+<entry><type>(oid|regproc)</type></entry>$!) {
    } elsif (defined $column && $line =~ m!^\s+<entry><literal><link\ linkend="[^"]+"><structname>([^<>]+)</structname></link>\.oid</literal></entry>$!) {
        $references = $1;
        if (!defined($pg_catalog_fk_map->{$table}->{$column}))
        {
            $pg_catalog_fk_map->{$table}->{$column} = $references;
        } elsif ($pg_catalog_fk_map->{$table}->{$column} ne $references) {
            die "Inconsistent data, $table.$column references both $pg_catalog_fk_map->{$table}->{$column} and $references";
        }
        $pg_catalog_fk_map->{$table}->{$column} = $references;
        if (!defined($pg_catalog_fk_map->{$references})) {
            $pg_catalog_fk_map->{$references} = {};
        }
    } else {
        undef($column);
        undef($references);
    }
}

my $dot = qq!
    digraph g {
        graph [
            rankdir = "LR"
        ];
        node [
            fontsize = "16"
            shape = "ellipse"
        ];
        edge [
        ];
!;

foreach my $table (sort keys %{$pg_catalog_fk_map}) {
    $dot .= qq!
        "$table" [
            headlabel = "$table"
            label = "$table | <oid> oid|!;
    foreach my $column (sort keys %{$pg_catalog_fk_map->{$table}}) {
        my $references = $pg_catalog_fk_map->{$table}->{$column};
        $dot .= "<$column> $column|";
    }
    chop($dot);
    $dot .= qq!"
            shape = "record"
        ];
    !;
}

my $id = 0;

foreach my $table (sort keys %{$pg_catalog_fk_map}) {
    foreach my $column (sort keys %{$pg_catalog_fk_map->{$table}}) {
        my $references = $pg_catalog_fk_map->{$table}->{$column};
        $dot .= qq!
        "$table":$column -> "$references":oid [
            id = $id
        ];
        !;
        $id++;
    }
}

$dot .= qq!
    }
!;

print $dot;
