#!/usr/bin/env python3
# See: https://github.com/getomni-ai/zerox/issues/57
#
# FIXME: cannot get this to execute; maybe a
#        bad python environment install ??
#

from pyzerox import zerox
import os
import asyncio
import argparse
from PyPDF2 import PdfReader
import subprocess
import shutil

def get_pdf_page_range(file_path):
    with open(file_path, 'rb') as file:
        reader = PdfReader(file)
        return list(range(1, len(reader.pages) + 1))
    
def get_libreoffice_command():
    """Determine whether to use 'libreoffice' or 'soffice' based on availability."""
    # Check if 'libreoffice' exists in the system
    if shutil.which('libreoffice'):
        return 'libreoffice'
    # Check if 'soffice' exists in the system
    elif shutil.which('soffice'):
        return 'soffice'
    else:
        raise FileNotFoundError("Neither 'libreoffice' nor 'soffice' was found on the system.")

def convert_to_pdf(source_path, output_dir):
    """Convert DOCX to PDF using LibreOffice."""
    try:
        print(f"Converting {source_path} to PDF...")
        subprocess.run(
            [get_libreoffice_command(), '--headless', '--convert-to', 'pdf', '--outdir', output_dir, source_path],
            check=True
        )
        print(f"Converted {source_path} to PDF successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error converting DOCX to PDF: {e}")
        return None
    
    pdf_filename = os.path.splitext(os.path.basename(source_path))[0] + '.pdf'
    return os.path.join(output_dir, pdf_filename)

# Parse command-line arguments
parser = argparse.ArgumentParser(description='Process a PDF file with zerox.')
parser.add_argument('file_path', type=str, help='The file path or URL of the PDF to process.')
parser.add_argument('--open_ai_key', type=str, required=True, help='The OpenAI API key.')
parser.add_argument('--model', type=str, required=False, help='The model to use. (default gpt-4o-mini)')
parser.add_argument('--output_dir', type=str, required=False, help='The output file name. (default ./tmp/zerox/FILENAME.md)')
parser.add_argument('--custom_system_prompt', type=str, required=False, help='The custom prompt to use. (default None)')
args = parser.parse_args()

# Use the file_path from the command-line arguments
file_path = args.file_path

# Convert docx to pdf if the file is not a PDF
convertible_formats = [
    "doc", "docx", "odt", "ott", "rtf", "html", "htm", "xml", "wps", "wpd",
    "xls", "xlsx", "ods", "ots", "csv", "tsv", "ppt", "pptx", "odp", "otp"
]

output_dir = args.output_dir if args.output_dir else "./tmp/zerox" ## directory to save the consolidated markdown file

if os.path.splitext(file_path)[1].lower().lstrip('.') in convertible_formats:
    file_path = convert_to_pdf(file_path, output_dir)
elif os.path.splitext(file_path)[1].lower().lstrip('.') == 'pdf':
    pass
else:
    print(f"File {file_path} with extension {os.path.splitext(file_path)[1].lower().lstrip('.')} is not convertible to PDF.")
    exit(1)

### Model Setup (Use only Vision Models) Refer: https://docs.litellm.ai/docs/providers ###

## placeholder for additional model kwargs which might be required for some models
kwargs = {}

## system prompt to use for the vision model
custom_system_prompt = args.custom_system_prompt if args.custom_system_prompt else None

###################### Example for OpenAI ######################
model = args.model if args.model else "gpt-4o-mini" ## openai model
os.environ["OPENAI_API_KEY"] = args.open_ai_key

###################### For other providers refer: https://docs.litellm.ai/docs/providers ######################

# Define main async entrypoint
async def main():
    select_pages = get_pdf_page_range(file_path)

    result = await zerox(file_path=file_path, model=model, output_dir=output_dir,
                        custom_system_prompt=custom_system_prompt, select_pages=select_pages, **kwargs)
    return result


# run the main function:
result = asyncio.run(main())

# print markdown result
print(result)
