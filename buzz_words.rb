#!/usr/bin/env ruby

puts "\nSkills:"
puts

puts DATA.read
          .split("\n")
          .map{|word| word.strip}
          .sort
          .uniq
          .select{|word| word.size > 0}
          .join(', ')

puts

__END__

ActiveModel
ActiveMQ
ActiveRecord
ActiveSupport
Ada
Agile
algorithms
Amazon Web Services (AWS)
AMQP
ant
Apache HTTPD
Application Program Interface (API)
Artificial Intelligence (AI)
AWK
backend
bash
Behavior Driven Development (BDD)
best practices
BitBucket
Bundler
C
C++
Casandra
CentOS
Chef
clang
Cloud
COBOL
code quality
code reviews
concurrency
configuration control board (CCB)
configuration management (CM)
Confluence
Continuous Integration (CI)
Corporate Maturity Model Integration (CMMI)
CouchDB
cpp
creative
CRuby
Crystal
csh
Cucumber
Customer Relationship Management (CRM)
CVS
data structures
Design Patterns
detail oriented
DevOps
Docker
DoD security clearance
Earned Value Management System (EVMS)
ejabberd
Elastic Cloud Computing (EC2)
ElasticSearch
ELK
ERB
Expert Systems
federal government
Fedora
FHIR
FORTRAN
friendly
Gemfile
Geographic Information Systems (GIS)
git
Github
Go
GoLang
guard
Guardfile
HAML
healthcare
HL7
infrastructure as a service (IaaS)
IRB
IRIX
Jenkins
JIRA
JRuby
JRuby
JSON
Kibana
Knowledge Management (KM)
Latent Symantic Indexing (LSI)
Lead Developer
lean-agile
Linux
LISP
LogStash
Lucene
Machine Learning
MacOSX
make
makefile
maven
mentor
MicroServices
MicroSoft (MS)
MiniTest
MongoDB
motivated
MRI
MRI
MS Excel
MS Office
MS PowerPoint
MS Project
MS Word
multithreading
MySQL
NGINX
NoSQL
object relationship model (ORM)
Object-oriented (OO)
Online Transaction Processing (OLTP)
OOA
OOD
OOP
open source
Oracle
outgoing
Pascal
peer review
PERL
PL/I
PL/M
PL/SQL
platform as a service (PaaS)
player-coach
PostgreSQL
Project Management
Project Manager
PROLOG
proof of concept (POC)
pry
Public Trust (VA)
Puma
Python
Python
RabbitMQ
Rack
Rails
Rake
rapid prototype
rapid prototyping
RDS
rea;-time messaging
RedHat
Redis
reek
Relational Database Management System (RDBMS)
Representational State Transfer (REST)
request for proposal (RFP)
requirements management
research and development (R&D)
Restful Web services
RethinkDB
Risk Management
Rspec
Rubinus
RuboCop
Ruby
Ruby on Rails (RoR)
RubyCritic
RubyGems
RubyOnRails
Rust
RVM
SCons
scripting
Scrum
scrum master
Sequel
server-side engineering
Service-oriented Architecture (SOA)
sh
shell
Simple Storage System (S3)
Sinatra
SOAP
software as a service (SaaS)
software design
Software Development Life-cycle (SDLC)
Solr
source control
SQL
ssh
statement of work (SOW)
static code analysis
SVN
TCP/IP
tcsh
TDD
Team leader
Thin
Thor
Tomcat
Trac
Twilio
Ubuntu
UML
unit testing
UNIX
Virtual Machine (VM)
VirtualBox
working manager
XML
XMPP
XSD
ZeroMQ


