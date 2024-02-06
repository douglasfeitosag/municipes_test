//=require jquery.mask.min.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.maskFields();
    }

    maskFields() {
        window.$('[data-masks-target="phone"]').mask('+55 (99) 9 9999-9999')
        window.$('[data-masks-target="cpf"]').mask('000.000.000-00')
    }
}
