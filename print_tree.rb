#!/usr/bin/env ruby
# ~/scripts/print_tree.rb

# TODO: fix this to take a file from the command line,
#       or maybe from a pipe to STDIN
#       that way we could do:
#         ag -l search_term | print_tree.rb
#

require 'tty-tree'

def generate_directory_tree(pathnames)
  structure = {}

  # Convert the array of pathnames into a nested hash
  pathnames.each do |pathname|
    # Start from the root of the structure
    current = structure

    # Split the pathname into parts and iteratively build the tree
    pathname.split('/').each do |part|
      current[part] ||= {}
      current = current[part]
    end
  end

  # Use TTY::Tree to generate the visual tree structure
  tree = TTY::Tree.new(structure)

  # Print the generated tree
  puts tree.render
end

# Example usage
path_array = %w[
app/uploaders/validate_pdf.rb
app/sidekiq/vbms/submit_dependents_pdf_job.rb
app/sidekiq/vbms/submit_dependents_pdf_encrypted_job.rb
spec/support/pdf_fill_helper.rb
lib/pdf_utilities/pdf_validator.rb
lib/pdf_fill/forms/va21p530.rb
lib/pdf_fill/forms/form_helper.rb
lib/pdf_fill/forms/maps/input_map_1010_ez.rb
lib/pdf_fill/forms/maps/key_map_1010_ez.rb
lib/pdf_fill/forms/form_base.rb
lib/pdf_fill/forms/va1010ez.rb
lib/pdf_fill/forms/va261880.rb
lib/pdf_fill/forms/va210781.rb
lib/pdf_fill/forms/va1010cg.rb
lib/pdf_fill/forms/va214142.rb
lib/pdf_fill/forms/va5655.rb
lib/pdf_fill/forms/va210781a.rb
lib/pdf_fill/forms/va281900.rb
lib/pdf_fill/forms/common_ptsd.rb
lib/pdf_fill/forms/va21p527ez.rb
lib/pdf_fill/forms/va210538.rb
lib/pdf_fill/forms/va21674.rb
lib/pdf_fill/forms/va686c674.rb
lib/pdf_fill/form_value.rb
lib/pdf_fill/filler.rb
lib/pdf_fill/extras_generator.rb
lib/pdf_fill/forms/va288832.rb
lib/pdf_fill/forms/va218940.rb
lib/pdf_fill/hash_converter.rb
lib/shrine/plugins/validate_unlocked_pdf.rb
lib/common/convert_to_pdf.rb
lib/benefits_intake_service/utilities/convert_to_pdf.rb
lib/pdf_info.rb
lib/decision_review/utilities/pdf_validation/configuration.rb
lib/decision_review/utilities/pdf_validation/service.rb
lib/central_mail/datestamp_pdf.rb
modules/simple_forms_api/app/services/simple_forms_api/pdf_filler.rb
modules/simple_forms_api/app/services/simple_forms_api/pdf_stamper.rb
modules/claims_api/app/sidekiq/claims_api/v2/disability_compensation_pdf_generator.rb
modules/claims_api/spec/support/pdf_matcher.rb
modules/claims_api/lib/pdf_generator_service/pdf_client.rb
modules/claims_api/lib/claims_api/poa_pdf_constructor/base.rb
modules/claims_api/lib/claims_api/poa_pdf_constructor/organization.rb
modules/claims_api/lib/claims_api/poa_pdf_constructor/signature.rb
modules/claims_api/lib/claims_api/poa_pdf_constructor/individual.rb
modules/claims_api/lib/claims_api/v2/disability_compensation_pdf_mapper.rb
modules/claims_api/lib/claims_api/evidence_waiver_pdf/pdf.rb
modules/vba_documents/app/swagger/vba_documents/document_upload/v1/pdf_dimension_attributes_swagger.rb
modules/vba_documents/app/swagger/vba_documents/document_upload/v1/pdf_upload_attributes_swagger.rb
modules/vba_documents/lib/vba_documents/pdf_inspector.rb
modules/health_quest/app/services/health_quest/questionnaire_manager/pdf_generator/footer.rb
modules/health_quest/app/services/health_quest/questionnaire_manager/pdf_generator/properties.rb
modules/health_quest/app/services/health_quest/questionnaire_manager/pdf_generator/appointment_info.rb
modules/health_quest/app/services/health_quest/questionnaire_manager/pdf_generator/demographics.rb
modules/health_quest/app/services/health_quest/questionnaire_manager/pdf_generator/header.rb
modules/health_quest/app/services/health_quest/questionnaire_manager/pdf_generator/questionnaire_response_info.rb
modules/health_quest/app/services/health_quest/questionnaire_manager/pdf_generator/composer.rb
modules/appeals_api/app/sidekiq/appeals_api/pdf_submit_job.rb
modules/appeals_api/app/models/concerns/appeals_api/pdf_output_prep.rb
modules/appeals_api/app/controllers/concerns/appeals_api/pdf_downloads.rb
modules/appeals_api/app/controllers/concerns/appeals_api/higher_level_reviews/pdf_form_field_v2_validator.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v1/form_fields.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v1/form_data.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v1/structure.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v1/pages/hearing_type_and_additional_issues.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v2/form_fields.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v2/form_data.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v2/structure.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v2/pages/long_data_and_extra_issues.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v2/pages/time_extension_reason.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v3/form_data.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v3/structure.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/notice_of_disagreement/v3/form_fields.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/generator.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/stamper.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v2/form_fields.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v2/form_data.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v2/structure.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v2/pages/additional_pages.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v3/form_fields.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v3/form_data.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v3/structure.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/supplemental_claim/v3/pages/additional_pages.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v2/form_data.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v2/form_fields.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v2/structure.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v2/pages/additional_issues.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v3/form_data.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v3/structure.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v3/form_fields.rb
modules/appeals_api/app/services/appeals_api/pdf_construction/higher_level_review/v3/pages/additional_issues.rb
modules/appeals_api/spec/support/shared_examples_for_pdf_downloads.rb
modules/appeals_api/spec/support/pdf_matcher.rb
modules/appeals_api/lib/appeals_api/sc_pdf_submit_wrapper.rb
modules/appeals_api/lib/appeals_api/nod_pdf_submit_wrapper.rb
modules/appeals_api/lib/appeals_api/hlr_pdf_submit_wrapper.rb
modules/appeals_api/db/migrate/20210525183405_add_pdf_version_api_version_to_appeals.rb
]

generate_directory_tree(path_array)


