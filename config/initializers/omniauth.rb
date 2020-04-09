Rails.application.config.middleware.use OmniAuth::Builder do 
    provider :github, 'd91bd23e4994b6b91fc8', '84b2669e1b2ba3ae1dae8f415e3eb291884e28f5'
end 