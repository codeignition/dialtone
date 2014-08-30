class Conference
  def initialize(participants)
    @participants   = participants
    @mixer_name     = "conference-#{Time.now.to_i}"
  end

  def start!
    participants = participant_list
    participants.each { |number| call_and_add(number) }
  end

  def participant_list
    self.participants.split(',')
  end

  def call_and_add(participant_number)
    actor_name = "#{@mixer_name}-#{participant_number}"
    Participant.supervise_as actor_name, participant_number
    participant = Celluloid::Actor[actor_name]
    sleep 0.02 # TODO - remove this .. refer https://github.com/celluloid/celluloid/pull/352
    participant.async.add_to(self)
  end

  def mixer_name
    @mixer_name
  end

  def participants
    @participants
  end
end
