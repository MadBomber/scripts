# ~/scripts/pdf2png.s

echo "TODO: flesh this out."
# mutool draw -o "./demo-%d.png" -r 300 -F png ./demo.pdf

# require 'tmpdir'

# # @param filename [String]
# # @yield page
# # @yieldparam file [File]
# def pdf_to_pngs(filename:)
#   Dir.mktmpdir do |dir|
#     system("mutool", "draw", "-o", "#{dir}/%d.png", "-F", "png", filename)

#     Dir.entries(dir).sort.each do |path|
#       next unless path.match?(/^\d+.png$/)
#       File.open("#{dir}/#{path}") do |file|
#         yield(file)
#       end
#     end
#   end
# end

# require 'omniai/openai'

# # @param file [File]
# # @param stream [IO]
# def png_to_markdown(file:, stream: $stdout)
#   client = OmniAI::OpenAI::Client.new
#   completion = client.chat(stream:) do |prompt|
#     prompt.system('You are an expert at converting files to markdown.')
#     prompt.user do |message|
#       message.text 'Convert the attached files to markdown.'
#       message.file(file, "image/png")
#     end
#   end
# end



# require 'tmpdir'
# require 'omniai/openai'

# # @param filename [String]
# # @yield page
# # @yieldparam file [File]
# def pdf_to_pngs(filename:)
#   Dir.mktmpdir do |dir|
#     system("mutool", "draw", "-o", "#{dir}/%d.png", "-F", "png", filename)

#     Dir.entries(dir).sort.each do |path|
#       next unless path.match?(/^\d+.png$/)
#       File.open("#{dir}/#{path}") do |file|
#         yield(file)
#       end
#     end
#   end
# end

# # @param file [File]
# # @param stream [IO]
# def png_to_markdown(file:, stream: $stdout)
#   client = OmniAI::OpenAI::Client.new
#   completion = client.chat(stream:) do |prompt|
#     prompt.system('You are an expert at converting files to Markdown.')
#     prompt.user do |message|
#       message.text 'Convert the attached files to Markdown.'
#       message.file(file, "image/png")
#     end
#   end
# end

# pdf_to_pngs(filename: "demo.pdf") { |file| png_to_markdown(file:) }

