# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kalenderwoche_session',
  :secret      => '51a1f1b7dd17ae2ee969b7bb566edec8fd4af17b352c9854a328f0fa7d4494bfef21201d2e5cb766814927a59d1f45005742967282c8e48a48dc75c7e0e461c6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
