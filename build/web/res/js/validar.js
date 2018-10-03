$(function() {


    $('.numero').on('input', function(event) {
        var string =  $(this).val().trim();

        if(!isNumero(string))
        {
            string = string.slice(0, -1);
            $(this).val(string);
        }
    });

    $('.calc').on('keydown', function(event) {
        var string =  $(this).val().trim();
        var key =  event.which;
        console.log(key);
        if(isNumero(string) || isSigno(key))
        {
            
        }
        else{
            string = string.slice(0, -1);
            $(this).val(string);
        }
    });
});

function isSigno(key)
{
    if(key == 187)
    {
        return true;
    }
    if(key == 189)
    {
        return true;
    }
    if(key == 187)
    {
        return true;
    }
    if(key == 42)
    {
        return true;
    }
    if(key == 55)
    {
        return true;
    }
}

function isNumero(cadena)
{
    if(isNaN(cadena))
    {
        return false;
    }
    else{
        return true;
    }
}

function isArith(cadena)
{
    if(isNumero(cadena) || isSigno(cadena))
    {
        return true;
    }
    else{
        return false;
    }
}

function throwError(){

}