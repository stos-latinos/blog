users = []
ips = []

def generate_login(number)
  charset = Array('A'..'Z') + Array('a'..'z')
  Array.new(number) { charset.sample }.join
end

def generate_ip
  "%d.%d.%d.%d" % [rand(256), rand(256), rand(256), rand(256)]
end

100.times do
  users.push(generate_login(15))
end

50.times do
  ips.push(generate_ip)
end

200000.times do |i|
  response = `curl -H "Content-Type: application/json" -d '{ "login": \"#{users[rand(100)]}\",
                                                             "title": "post#{i}",
                                                             "text": "text#{i}",
                                                             "author_ip": \"#{ips[rand(50)]}\" }' 'http://localhost:3000/posts.json'`
  3.times { `curl -H "Content-Type: application/json" -d '{ "value": \"#{rand(1..5)}\" }' 'http://localhost:3000/posts/#{JSON.parse(response)['id']}/set_rate'` } if rand > 0.5
end