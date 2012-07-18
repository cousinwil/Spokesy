class RideJob < Struct.new()
include ClubHelper

	def perform
		Ride.new.findRides
		Delayed::Job.enqueue(RideJob.new, 0, 2.hours_from_now)
	end
end