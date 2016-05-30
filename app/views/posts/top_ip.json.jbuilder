json.array! @top_ips do |ip|
  json.set! :ip, ip.to_s
  json.set! :authors do
    json.array! Post.where(author_ip: ip).includes(:user).pluck(:login)
  end
end