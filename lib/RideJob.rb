class RideJob
#include "#{Rails.root.to_s}"/app/helpers/ClubHelper

	def perform
		Ride.find_rides
		Delayed::Job.enqueue(TweetJob.new(), 0, 15.minutes.from_now)
	end
end