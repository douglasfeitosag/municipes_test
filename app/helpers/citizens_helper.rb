module CitizensHelper
  def headers
    [
      t("activerecord.attributes.citizen.id"),
      t("activerecord.attributes.citizen.name"),
      t("activerecord.attributes.citizen.cpf"),
      t("activerecord.attributes.citizen.email"),
    ]
  end
end