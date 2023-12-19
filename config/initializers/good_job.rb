Rails.application.configure do
  config.good_job.cron = {
    hello_world: {
      cron: "every 5 minutes",
      class: "HelloWorldJob"
    }
  }
end
