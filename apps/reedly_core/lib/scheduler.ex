defmodule Reedly.Core.Scheduler do
  @moduledoc "Run jobs by schedule"

  use Quantum.Scheduler,
    otp_app: :reedly_core
end
