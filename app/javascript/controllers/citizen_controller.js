//=require jquery.mask.min.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.maskFields()
    }

    handleStateChange = (event) => {
        const id = event.target.value
        this.fetchCities(id)
    }

    maskFields() {
        window.$('[data-masks-target="phone"]').mask('+55 (99) 9 9999-9999')
        window.$('[data-masks-target="cpf"]').mask('000.000.000-00')
    }

    fetchCities = (id) => {
        fetch(`/citizens/cities?state_id=${id}`)
            .then((response) => response.text())
            .then((data) => {
                this.element.querySelector("#citizen_city_id").innerHTML = data
            })
    }
}
