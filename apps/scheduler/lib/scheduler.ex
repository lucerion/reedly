defmodule Reedly.Scheduler do
  @moduledoc "Run jobs by schedule"

  use Quantum.Scheduler,
    otp_app: :core
end
