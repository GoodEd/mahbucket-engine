module Mahbucket
  module ApplicationHelper
    def theme
      Rails.application.secrets.theme
    end
  end
end
