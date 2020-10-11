require 'factory_bot'

namespace :dev do
  namespace :db do
    desc "Popula o banco de desenvolvimento com dados fake"
    task populate: :environment do
      if Rails.env.development?
        show_spinner("Dropping Database...", "Mission is completed!") { %x[rails db:drop] }
        show_spinner("Creating Database...", "Mission is completed!") { %x[rails db:create] }
        show_spinner("Executing Migrations...", "Mission is completed!") { %x[rails db:migrate] }
        show_spinner("Executing Seeds...", "Mission is completed!") { %x[rails db:seed] }
        show_spinner("Populing Database...", "Mission is completed!") { FactoryBot.create_list(:offer, 60) }
      end
    end

    private

    def show_spinner(message_start, message_end)
      spinner = TTY::Spinner.new("[:spinner] #{message_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{ message_end })")
    end
  end
end
