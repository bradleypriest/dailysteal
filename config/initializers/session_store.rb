# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_agg_session',
  :secret      => '3b65f9aece8c87acd9abcc77e195b457625a4969463fbe1e48f76c07c4bd060c9d75870d062ad8938874da6c1ec776b7563c890df5ed948f27352db820f2bfaf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
