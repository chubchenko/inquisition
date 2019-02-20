# Bullet

Rails.application.configure do
  config.after_initialize do
    Bullet.enable = true
    Bullet.sentry = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.rails_logger = true
    Bullet.honeybadger = true
    Bullet.bugsnag = true
    Bullet.airbrake = true
    Bullet.rollbar = true
    Bullet.add_footer = true
  end
end
