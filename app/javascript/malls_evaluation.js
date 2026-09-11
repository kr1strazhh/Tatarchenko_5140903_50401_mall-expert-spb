document.addEventListener("turbo:load", () => {
  const workspace = document.querySelector("[data-mall-workspace]")
  if (!workspace) return

  const themeSelect = document.querySelector("#theme-select")
  const emptyState = document.querySelector("#empty-state")
  const cardBody = document.querySelector("#mall-card-body")
  const form = document.querySelector("#evaluation-form")
  const ratingRange = document.querySelector("#rating-range")
  const ratingOutput = document.querySelector("#rating-output")
  const comment = document.querySelector("#comment")
  const mallItemId = document.querySelector("#mall-item-id")
  const locale = document.body.dataset.locale || "ru"

  function csrfToken() {
    return document.querySelector("meta[name='csrf-token']")?.getAttribute("content")
  }

  function showEmpty(message) {
    emptyState.classList.remove("is-hidden")
    cardBody.classList.add("is-hidden")
    form.classList.add("is-hidden")
    emptyState.querySelector("p").textContent = message
  }

  function showMall(payload) {
    const mall = payload.mall_item
    mallItemId.value = mall.id
    document.querySelector("#mall-image").src = mall.image_url
    document.querySelector("#mall-image").alt = mall.name
    document.querySelector("#mall-theme").textContent = mall.theme
    document.querySelector("#mall-name").textContent = mall.name
    document.querySelector("#mall-address").textContent = mall.address
    document.querySelector("#mall-description").textContent = mall.description
    document.querySelector("#average-rating").textContent = mall.average_rating || "—"
    ratingRange.value = 50
    ratingOutput.textContent = "50"
    comment.value = ""
    emptyState.classList.add("is-hidden")
    cardBody.classList.remove("is-hidden")
    form.classList.remove("is-hidden")
  }

  async function loadNextMall() {
    const params = new URLSearchParams({ locale })
    if (themeSelect.value) params.set("theme_id", themeSelect.value)

    const response = await fetch(`/api/v1/malls?${params.toString()}`, {
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken()
      }
    })
    const payload = await response.json()

    if (!response.ok) {
      showEmpty(payload.error || "Unable to load data")
      return
    }

    if (payload.done) {
      showEmpty(payload.message)
    } else {
      showMall(payload)
    }
  }

  ratingRange.addEventListener("input", () => {
    ratingOutput.textContent = ratingRange.value
  })

  themeSelect.addEventListener("change", loadNextMall)

  form.addEventListener("submit", async (event) => {
    event.preventDefault()

    const response = await fetch(`/api/v1/malls?locale=${locale}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken()
      },
      body: JSON.stringify({
        mall_item_id: mallItemId.value,
        rating: ratingRange.value,
        comment: comment.value
      })
    })
    const payload = await response.json()

    if (!response.ok) {
      window.alert(payload.errors?.join(", ") || payload.error || "Unable to save evaluation")
      return
    }

    await loadNextMall()
  })
})
