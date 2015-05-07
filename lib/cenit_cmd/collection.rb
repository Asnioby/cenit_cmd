module CenitCmd

  class Collection < Thor::Group
    include Thor::Actions

    desc "builds a cenit_hub collection"
    argument :file_name, :type => :string, :desc => '', :default => '.' #rails app_path

    source_root File.expand_path('../templates/collection', __FILE__)

    def generate
      use_suffix '_collection'

      empty_directory file_name

      directory 'lib', "#{file_name}/lib"
      directory 'bin', "#{file_name}/bin"

      template 'collection.gemspec', "#{file_name}/#{file_name}.gemspec"
      template 'Gemfile', "#{file_name}/Gemfile"
      template 'gitignore', "#{file_name}/.gitignore"
      template 'LICENSE', "#{file_name}/LICENSE"
      template 'Rakefile', "#{file_name}/Rakefile"
      template 'README.md', "#{file_name}/README.md"
      template 'rspec', "#{file_name}/.rspec"
      template 'spec/spec_helper.rb.tt', "#{file_name}/spec/spec_helper.rb"
    end

    def final_banner
      say %Q{
        #{'*' * 80}

        Consider listing your collection in https://rubygems.org

        #{'*' * 80}
      }
    end

    no_tasks do
      def class_name
        Thor::Util.camel_case file_name
      end

      def use_suffix(suffix)
        unless file_name =~ /#{suffix}$/
          @file_name = Thor::Util.snake_case(file_name) + suffix
        end
      end
    end

  end
end