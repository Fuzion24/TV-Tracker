PAPERCLIP_CONFIG = YAML.load(ERB.new(File.read("#{Rails.root}/config/paperclip.yml")).result)[Rails.env]

Paperclip.interpolates :path do |asset, style|
    return ("%018d" % asset.instance.id).scan(/\d{3}/).join("/")
end

Paperclip.interpolates :sha1 do |asset, style|
  return asset.instance.icon_sha1
end