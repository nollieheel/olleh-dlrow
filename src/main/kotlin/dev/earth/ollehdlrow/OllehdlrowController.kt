package dev.earth.ollehdlrow

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class HelloWorldController {

    @RequestMapping("/")
    fun home(): String {
        return "Convert build-and-push-image to config job"
    }
}
