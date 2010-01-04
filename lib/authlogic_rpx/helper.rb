module AuthlogicRpx
	module Helper

		# helper to insert an embedded iframe RPX login
		# takes options hash:
		#   * <tt>app_name:</tt> name of the application (will be prepended to RPX domain and used in RPX dialogues)
		#   * <tt>return_url:</tt> url for the RPX callback (e.g. user_sessions_url)
		#   * <tt>add_rpx:</tt> if true, requests RPX callback to add to current session. Else runs normal authentication process (default)
		#
		def rpx_embed(options = {})
			params = (
				{ :authenticity_token => form_authenticity_token, :add_rpx => options[:add_rpx] }.collect { |n| "#{n[0]}=#{ u(n[1]) }" if n[1] }
			).compact.join('&')
			RPXNow.embed_code(options[:app_name], u( options[:return_url] + '?' + params ) )
		end

		# helper to insert a link to pop-up RPX login
		# takes options hash:
		#   * <tt>link_text:</tt> text to use in the link
		#   * <tt>app_name:</tt> name of the application (will be prepended to RPX domain and used in RPX dialogues)
		#   * <tt>return_url:</tt> url for the RPX callback (e.g. user_sessions_url)
		#   * <tt>add_rpx:</tt> if true, requests RPX callback to add to current session. Else runs normal authentication process (default)
		#   * <tt>unobtrusive:</tt> true/false; sets javascript style for link. Default: true
		#
		# The options hash may include other options as supported by rpx_now (see http://github.com/grosser/rpx_now)
		#
		def rpx_popup(options = {})
			options = { :unobtrusive => true, :add_rpx => false }.merge( options )
			unobtrusive = options[:unobtrusive]
			add_rpx = options.delete( :add_rpx )
			app_name = options.delete( :app_name )
			link_text = options.delete( :link_text )
			return_url = options.delete( :return_url ) + '?' + (
				{ :authenticity_token => form_authenticity_token, :add_rpx => add_rpx }.collect { |n| "#{n[0]}=#{ u(n[1]) }" if n[1] }
			).compact.join('&') 
			
			# as of rpx_now 0.6.11, there is still an issue with url-encoding of the return path containing additional parameters 
			# (as we are using here to get the form_authenticity_token returned.
			# To get around this, we need to ensure hrefs are url-encoded, 
			# while the link provided to the rpx_now javascript popup should _not_ be url-encoded
			if unobtrusive
  			RPXNow.popup_code( link_text, app_name,	u( return_url ), options	)
			else
  			RPXNow.popup_code( link_text, app_name,	u( return_url ), options.merge( :unobtrusive => true )	) +
        RPXNow.popup_source(app_name, return_url, options ) 
      end
		end

	end
end