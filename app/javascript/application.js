import "@hotwired/turbo-rails"
import "controllers"
import "malls_evaluation"
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
