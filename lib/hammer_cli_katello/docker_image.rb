module HammerCLIKatello
  class DockerImageCommand < HammerCLIKatello::Command
    resource :docker_images
    command_name 'image'
    desc 'Manage docker images'

    class ListCommand < HammerCLIKatello::ListCommand
      output do
        field :id, _("ID")
        field :image_id, _("Image ID")
        field :size, _("Size")
        field :tag_count, _("Tags")
      end

      build_options do |o|
        o.expand.including(:products, :organizations, :content_views)
      end

      def extend_data(data)
        data["tag_count"] = data["tags"].size
        data
      end
    end

    class InfoCommand < HammerCLIKatello::InfoCommand
      output do
        field :id, _("ID")
        field :image_id, _("Image ID")
        field :size, _("Size")

        collection :tags, _("Tags") do
          field :repository_id, _("Repository ID")
          field :name, _("Tag")
        end
      end

      build_options
    end

    autoload_subcommands
  end
end