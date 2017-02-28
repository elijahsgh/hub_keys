Puppet::Parser::Functions.newfunction(:hub_keys, :type => :rvalue,
:doc => <<-EOS
Get a hash of user keys published via github/gitlab.
EOS
  ) do |args|
    raise(Puppet::ParseError, "hub_keys(): Wrong number of " +
      "arguments: gitlab_user_keys('username', gitlab_url)") if args.size < 2

    user, server = args

    uri = URI("#{server}/#{user}.keys")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = server.start_with?('https') ? true : false

    req = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(req)
    code = response.code

    if code != "200"
      raise(Puppet::ParseError, "Get #{username} result: #{code}")
    end

    key_i = 1
    key_hash = {}

    response.body.lines.each do |key|
      key_fields = key.strip.split
      key_hash["#{user} gitlab key #{key_i}"] = {
        'ensure' => 'present',
        'type' => key_fields[0],
        'key' => key_fields[1],
        'user' => user,
        'name' => "#{user}-gitlab-key-#{key_i}",
        'onlyif' => "test -d ~#{user}"
      }
      key_i += 1
    end

    key_hash
end
