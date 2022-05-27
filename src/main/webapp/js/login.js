$(document).ready(function(){
    function isEmpty(text){
        if(text === undefined || text === null || text === "") return true
        return false
    }

    $('#loginForm').on('submit', function (event){
        const userId = $("input[name='userId']").val()
        const password = $("input[name='password']").val()

        if(isEmpty(userId) || isEmpty(password)){
            event.preventDefault()
            $('#errorLabel').text("User ID and Password must be filled")
        }
    })

    $('.js-tilt').tilt({
        scale: 1.1
    })
})