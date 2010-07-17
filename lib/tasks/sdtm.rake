require 'active_record/fixtures'
require 'rubygems'
require 'fastercsv'
require File.join( RAILS_ROOT, 'vendor/plugins/seed-fu/lib/seed-fu/writer' )


namespace :db do
  namespace :sdtm do
    desc 'Create Seed for SDTM dict'
    task :create => :environment do
      seed_writer_sdtm_categories = SeedFu::Writer::SeedMany.new(
        :seed_file  => File.expand_path("db/fixtures/01_sdtm_categories.rb", RAILS_ROOT),
        :seed_model => 'SdtmCategory',
        :seed_by    => ['code', 'id']
      )
      seed_writer_sdtm_answers = SeedFu::Writer::SeedMany.new(
        :seed_file  => File.expand_path("db/fixtures/02_sdtm_answers.rb", RAILS_ROOT),
        :seed_model => 'SdtmAnswer',
        :seed_by    => ['code', 'sdtm_category_id']
      )

      sdtm_category_id = 0
      sdtm_answer_id = 0 # this key should be common for both tables to simplify DB compare
      FasterCSV.foreach(File.expand_path("db/sdtm.csv",RAILS_ROOT),
                        :quote_char => '"',
                        :headers => :first_row,
                        :return_headers => false,
                        :col_sep=>';' ) do |row|
        sdtm_answer_id += 1
        
        row_data = row
        #p row

        codelist = row_data['Codelist Code']
        if codelist.blank?
          sdtm_category_id += 1
          seed_writer_sdtm_categories.add_seed({
            :id => sdtm_category_id,
            :code => row_data['Code'],
            :extensible => ((row_data['Codelist Extensible (Yes/No)'] =='Yes'?true:false) unless row_data['Codelist Code']),
            :name => row_data['Codelist Name'],
            :submission_value => row_data['CDISC Submission Value'].gsub("\\","\\\\\\\\").gsub("'","\\\\'"),
            :cdisc_preferred_term => row_data['CDISC Preferred Term'].gsub("\\","\\\\\\\\").gsub("'","\\\\'"),
            :synonyms => (row_data['CDISC Synonym(s)'].gsub("\\","\\\\\\\\").gsub("'","\\\\'") if row_data['CDISC Synonym(s)']),
            :definition => row_data['CDISC Definition'].gsub("\\","\\\\\\\\").gsub("'","\\\\'"),
            :nci_preferred_term => (row_data['NCI Preferred Term'].gsub("\\","\\\\\\\\").gsub("'","\\\\'") if row_data['NCI Preferred Term']),
            :read_only => true
          })
        else
          seed_writer_sdtm_answers.add_seed({
            :id => sdtm_answer_id,
            :code => row_data['Code'],
            :submission_value => row_data['CDISC Submission Value'].gsub("\\","\\\\\\\\").gsub("'","\\\\'"),
            :cdisc_preferred_term => row_data['CDISC Preferred Term'].gsub("\\","\\\\\\\\").gsub("'","\\\\'"),
            :synonyms => (row_data['CDISC Synonym(s)'].gsub("\\","\\\\\\\\").gsub("'","\\\\'") if row_data['CDISC Synonym(s)']),
            :definition => row_data['CDISC Definition'].gsub("\\","\\\\\\\\").gsub("'","\\\\'"),
            :nci_preferred_term => (row_data['NCI Preferred Term'].gsub("\\","\\\\\\\\").gsub("'","\\\\'") if row_data['NCI Preferred Term']),
            :sdtm_category_id => sdtm_category_id,
            :read_only => true
          })
        end
      end
      seed_writer_sdtm_categories.finish
      seed_writer_sdtm_answers.finish
    end
  end
  
  namespace :domain do
    desc 'Create Seed for Domains dict'
    task :create => :environment do
      SEED_FILE =  File.expand_path("db/fixtures/03_domain.rb", RAILS_ROOT)
      seed_writer = SeedFu::Writer::Seed.new(
        :seed_file  => SEED_FILE,
        :seed_model => 'Domain',
        :seed_by    => [:code]
      )
      
      FasterCSV.foreach(File.expand_path("db/domain.csv",RAILS_ROOT),
                        :quote_char => '"',
                        :headers => :first_row,
                        :return_headers => false,
                        :col_sep=>';' ) do |row|
        row_data = row
        seed_writer.add_seed({
          :code => row_data['Code'],
          :name => row_data["Domain"],
          :domain_class => row_data['Class'],
          :description => row_data['Description'].gsub("\\","\\\\\\\\").gsub("'","\\\\'")
        })
      
      end
      seed_writer.finish
    end
  end
  
  namespace :cdash do
    desc 'Create Seed for CDASH questions dict'
    task :create => :environment do
      SEED_FILE =  File.expand_path("db/fixtures/04_cdash_questions.rb", RAILS_ROOT)
      seed_writer = SeedFu::Writer::SeedMany.new(
        :seed_file  => SEED_FILE,
        :seed_model => 'CdashQuestion',
        :seed_by    => [:domain_id, :variable_name ]
      )
      
      FasterCSV.foreach(File.expand_path("db/cdash.csv",RAILS_ROOT),
                        :quote_char => '"',
                        :headers => :first_row,
                        :return_headers => false,
                        :col_sep=>';' ) do |row|
        row_data = row
        #Domain.find_by_code(row["Domain"])
      #p row
      sdtm_category = SdtmCategory.find_by_code(row["SDTM Term Code"])

      seed_writer.add_seed({
        :data_collection_field => clear(row["Data Collection Field"]),
        :domain_id => Domain.find_by_code(row["Domain"]).id,
        :number => row["Number"],
        :variable_name => clear(row[ "Variable Name"]),
        :definition => clear(row[ "Definition"]),
        :completion_instructions => clear(row["Case Report Form Completion Instructions"]),
        :sponsor_info => clear(row["Additional Information for Sponsors"]),
        :core => clear(row["CDASH Core"]),
        :sdtm_category_id => (sdtm_category.nil? ? nil : sdtm_category.id)
        })
      end
      seed_writer.finish
    end
  end
  
end

def clear(val)
  val.nil? ? nil : val.gsub("\\","\\\\\\\\").gsub("'","\\\\'").strip
end
