import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect = () => {
        this.form = this.element.querySelector("form")
        this.form.addEventListener("submit", this.handleSubmit)
        this.fetchData("")
    }

    handleSubmit = (event) => {
        event.preventDefault()

        const searchTerm = event.target.querySelector("#search").value

        this.fetchData(searchTerm)
    }

    fetchData = (searchTerm) => {
        fetch(`/citizens/data?q=${searchTerm}`)
            .then((response) => response.text())
            .then((data) => {
                this.element.querySelector("[data-target='rows']").innerHTML = data
            })
    }
}