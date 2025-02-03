module DemoProject
  extend ActiveSupport::Concern

  class_methods do
    def demo
      first || load_demo_project
    end

    private

    def load_demo_project
      return first if any?

      # Load seeds if no projects exist
      load Rails.root.join('db/seeds.rb')
      first
    end
  end
end
