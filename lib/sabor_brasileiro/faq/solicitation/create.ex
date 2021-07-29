defmodule SaborBrasileiro.FAQ.Solicitations.Create do
  alias SaborBrasileiro.{Repo, FAQSolicitation}

  def call(params) do
    params
    |> FAQSolicitation.changeset()
    |> Repo.insert()
  end
end
