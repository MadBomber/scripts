#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'csv'
require 'pathname'

#
# ReadBookChapter
#
# Processes a BibleGateway.com bible chapter page, which contains verse text
# in a variety of tags (typically but not always p). Each verse is comprised
# of one or more spans tagged with a unique verse class identifier. Find each
# one, concatenate the verse text, output it in tabular form, and also output
# a text file containing the verse content of this chapter alone.
#
# Arguments:
#  book, the title of the book containing this chapter
#  bookNum, the number of the book containing this chapter
#  url, the URL of page containing the text of this chapter
#  output, stream to write output to
#
def ReadBookChapter(book, bookNum, url, output, dir_path=Pathname.pwd)

	# No verses have been read yet.
	chapterVerses    = []

	# Read and parse the chapter page.
	page             = Nokogiri::HTML(open(URI.escape(url)))

	# Find the first [or any] verse, just so we can figure out how the verses
	# of this chapter are tagged. (Abbreviation formats vary, so don't guess.)
	firstVerse       = page.at('p span.text')
	firstVerseClass  = firstVerse['class'].split(' ')[1]
	parts            = firstVerseClass.scan(/(.+?)-(.+?)-(.+?)/)[0]
	bookCode         = parts[0]
	chapterNum       = parts[1]
	verseNum         = parts[2]

	while true

		# Assemble tag used to find all the elements that comprise this verse.
		# (Initially identical to firstVerseClass, but we'll soon increment verseNum)
		verseClass = format("%s-%s-%s", bookCode, chapterNum, verseNum)

		# Search the page for all elements tagged with verseClass (maybe >1).
		## Technically speaking, CSS identifiers should not start with numerals,
		## so verse class tags for books starting with a digit (like "1Sam" for
		## "1 Samuel") violate this convention. As a result, Nokogiri's CSS-style
		## search method fails, so we use an Xpath selector instead.
		## verseParts = page.search("p span.#{verseClass}")
		verseParts = page.search("//p//span[@class='text #{verseClass}']|//table//span[@class='text #{verseClass}']")

		# Call it quits for this chapter if no matches for this verseNum.
		break if verseParts == nil or verseParts.empty?

		STDOUT << "#{verseNum} "
		STDOUT.flush

		# Get list of text tagged as this verse, minus any extraneous notes, etc.
		verseParagraphs = []
		verseParts.each do |versePart|
			versePart.search('span.chapternum,sup.versenum,sup.crossreference,sup.footnote').remove
			verseParagraphs.push(versePart.content)
			# .squeeze(' ').strip
		end

		# Concatenate the parts of this verse,
		verseText = verseParagraphs.join("\n\n")

		# add it to the list of verses in this particular chapter,
		chapterVerses.push(verseText)

		# and write it out to the output table (along with book, chapter, and number).
		output << [book, chapterNum, verseNum, verseText]

		# Increment the verse number and get ready to do it all over again!
		verseNum.succ!
	end

	STDOUT << "\n"

  # TODO: Put these files into the same directory as the csv_path
	# Dump the concatenated contents of chapterVerses to a text file.
	chapterFilename    = format("%02d_%s_%03d.txt", bookNum, book.gsub(' ','_'), chapterNum)
	chapter_file_path  = dir_path + chapterFilename

  File.open(chapter_file_path, 'w') do |file|
		file.puts chapterVerses.join("\n")
	end

end # def ReadBookChapter(book, bookNum, url, output)


#
# ReadIndex
#
# Processes a BibleGateway.com bible index, which is essentially a list of links
# to individual bible chapter pages. Identifies each chapter link in the index
# and hands it off to ReadBookChapter for verse extraction.
#
# Arguments:
#  url, URL of the BibleGateway.com bible index to process
#  output, stream to write output to
#
def ReadIndex(url, output, csv_dir=Pathname.pwd)

	# Book 1 is assumed to be titled "Genesis".
	lastBookTitle  = "Genesis"
	bookNum        = "1"

	# Read and parse the index page.
	testament      = Nokogiri::HTML(open(URI.escape(url)))

	# Just get the table of book/chapter links.
	bookTable      = testament.at('table.infotable')

	# Find each link in the table...
	bookTable.search('a').each do |chapterLink|

		# This is the URL of the page for this chapter.
		chapterUrl    = 'http://www.biblegateway.com' + chapterLink['href']

		# Get the book title and chapter number associated with each link.
		titleString   = chapterLink['title']
		splitChar     = titleString.rindex(' ')
		bookTitle     = titleString[0..splitChar-1]
		chapterNum    = titleString[splitChar+1..-1]

		# Keep track of the book number (used just for titling chapter files).
		bookNum.succ! if bookTitle != lastBookTitle

		# Get ReadBookChapter on the phone and tell him to read this chapter.
		puts "Reading #{bookTitle} #{chapterNum}:"
		ReadBookChapter(bookTitle, bookNum, chapterUrl, output, csv_dir)
		lastBookTitle = bookTitle
	end

end # def ReadIndex(url, output)

###########################################################
## Main

# Assign default index URL, but override it if an index URL is explicitly specified.
indexUrl = "http://www.biblegateway.com/versions/New-International-Version-NIV-Bible/"

# Print basic usage information and quit if we don't have one or two arguments.
if ARGV.size < 1 or ARGV.size > 2
	STDERR.puts "\nusage: imbibler.rb OUTPUT [INDEX]"
	STDERR.puts "\nINDEX URL defaults to that of the NIV Bible:"
	STDERR.puts "\n#{indexUrl}"
	STDERR.puts "\nText files containing the text of each chapter are output to the current"
	STDERR.puts "working directory with names \"BB BOOK CCC.txt\" where BB is the book"
	STDERR.puts "number, BOOK is the book title, and CCC is the chapter number."
	STDERR.puts
  exit 1
end

indexUrl = ARGV[1] if ARGV.size == 2

csv_path = Pathname.new(ARGV.shift).realpath

# Create a comma-separated value file for the output, and start processing the index.
csv = CSV.open(csv_path, 'w')
ReadIndex(indexUrl, csv, csv_path.parent)
csv.close

