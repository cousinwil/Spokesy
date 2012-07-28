class TweetJob
#include "#{Rails.root.to_s}"/app/helpers/ClubHelper

	def perform
		Tweet.pull
	ensure
		Delayed::Job.enqueue(RideJob.new(), 0, 15.minutes.from_now)
	end
end