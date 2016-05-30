json.array! @top do |post|
  json.call(post, :title, :text)
end