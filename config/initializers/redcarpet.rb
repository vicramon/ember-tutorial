require 'rouge/plugins/redcarpet'

class HTMLwithPygments < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
  include Redcarpet::Render::SmartyPants
end
