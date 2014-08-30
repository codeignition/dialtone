class Participant
  include Celluloid

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def add_to(conference)
    call = Adhearsion::OutboundCall.originate @phone_number, from: "codeignition", controller: CallController
    call.on_answer { |event| on_answer(event, call, conference.mixer_name) }
  end

  def on_answer(event, call, mixer_name)
    call.join mixer_name: mixer_name
  end
end
