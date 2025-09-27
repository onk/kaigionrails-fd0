require"ipaddr";module ActionDispatch;class RemoteIp;class IpSpoofAttackError<StandardError;end;TRUSTED_PROXIES=["127.0.0.0/8",
"::1",
"fc00::/7",
"10.0.0.0/8",
"172.16.0.0/12",
"192.168.0.0/16",
].map{|proxy|IPAddr.new(proxy)};attr_reader:check_ip,:proxies;def initialize(app,ip_spoofing_check=true,custom_proxies=nil)@app=app;@check_ip=ip_spoofing_check;@proxies=if custom_proxies.blank?;TRUSTED_PROXIES;elsif custom_proxies.respond_to?(:any?);custom_proxies;else raise(ArgumentError,"          Setting config.action_dispatch.trusted_proxies to a single value isn't
          supported. Please set this to an enumerable instead. For
          example, instead of:

          config.action_dispatch.trusted_proxies = IPAddr.new(\"10.0.0.0/8\")

          Wrap the value in an Array:

          config.action_dispatch.trusted_proxies = [IPAddr.new(\"10.0.0.0/8\")]

          Note that passing an enumerable will *replace* the default set of trusted proxies.
");end;end;def call(env)req=ActionDispatch::Request.new env;req.remote_ip=GetIp.new(req,check_ip,proxies);@app.call(req.env);end;class GetIp;def initialize(req,check_ip,proxies)@req=req;@check_ip=check_ip;@proxies=proxies;end;def calculate_ip;remote_addr=ips_from(@req.remote_addr).last;client_ips=ips_from(@req.client_ip).reverse!;forwarded_ips=ips_from(@req.x_forwarded_for).reverse!;should_check_ip=@check_ip&&client_ips.last&&forwarded_ips.last;if should_check_ip&&!forwarded_ips.include?(client_ips.last);raise IpSpoofAttackError,"IP spoofing attack?! ""HTTP_CLIENT_IP=#{@req.client_ip.inspect} ""HTTP_X_FORWARDED_FOR=#{@req.x_forwarded_for.inspect}";end;ips=forwarded_ips+client_ips;ips.compact!;filter_proxies(ips+[remote_addr]).first||ips.last||remote_addr;end;def to_s;@ip||=calculate_ip;end;private;def ips_from(header)
return [] unless header;ips=header.strip.split(/[,\s]+/);ips.select! do |ip|range=IPAddr.new(ip).to_range;range.begin==range.end;rescue ArgumentError;nil;end;ips;end;def filter_proxies(ips)
ips.reject do |ip|@proxies.any?{|proxy|proxy===ip};end;end;end;end;end
