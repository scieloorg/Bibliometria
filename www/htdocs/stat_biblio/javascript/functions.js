function submit_POST_METHOD(the_form)
{
	the_form.submit();
}

function validate_3_4_7(the_form)
{
    var elem = null;
    
    elem = findElementByName(the_form, "YNG[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_yng_msg.value);
        return false;
    }
    
    elem = findElementByName(the_form, "CITED[]");
    if (isSelection(elem))
    {
        if(elem.selectedIndex == -1)
        {
            alert(document.formMessages.js_cited_msg.value);
            return false;
        }
        if (countSelectedOptions(elem) > max_selection)
        {
            alert(document.formMessages.js_max_selection.value);
            elem.selectedIndex = -1;
            return false;
        }        
    }

    return true;
}

function validate_9(the_form)
{
    var elem = null;

    elem = findElementByName(the_form, "YED[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_yed_msg.value);
        return false;
    }

    elem = findElementByName(the_form, "CITED[]");
    if (isSelection(elem))
    {
        if(elem.selectedIndex == -1)
        {
            alert(document.formMessages.js_cited_msg.value);
            return false;
        }
        if (countSelectedOptions(elem) > max_selection)
        {
            alert(document.formMessages.js_max_selection.value);
            elem.selectedIndex = -1;
            return false;
        }        
    }

    elem = findElementByName(the_form, "YNG[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_yng_msg.value);
        return false;
    }

    elem = findElementByName(the_form, "COUNT_SCI[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_count_sci_msg.value);
        return false;
    }
    
    return true;
}

function validate_11(the_form)
{
    var elem = null;

    elem = findElementByName(the_form, "YED[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_yed_msg.value);
        return false;
    }

    elem = findElementByName(the_form, "CITING[]");
    if (isSelection(elem))
    {
        if(elem.selectedIndex == -1)
        {
            alert(document.formMessages.js_citing_msg.value);
            return false;
        }
        if (countSelectedOptions(elem) > max_selection)
        {
            alert(document.formMessages.js_max_selection.value);
            elem.selectedIndex = -1;
            return false;
        }        
    }

    elem = findElementByName(the_form, "YNG[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_yng_msg.value);
        return false;
    }

    elem = findElementByName(the_form, "COUNT_SCI[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_count_sci_msg.value);
        return false;
    }
    
    return true;
}

function validate_16(the_form)
{
    var elem = null;

    elem = findElementByName(the_form, "CITED[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_cited_msg.value);
        return false;
    }

    elem = findElementByName(the_form, "PAIS1[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_pais1_msg.value);
        return false;
    }

    elem = findElementByName(the_form, "PAIS2[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_pais2_msg.value);
        return false;
    }
    
    elem = findElementByName(the_form, "YNG[]");
    if (isSelection(elem) && elem.selectedIndex == -1)
    {
        alert(document.formMessages.js_yng_msg.value);
        return false;
    }

    return true;
}

function findElementByName(the_form, the_name)
{
    var ret = null;
    
    for(var i = 0; the_form.elements.length; i++)
    {
        var elem = the_form.elements[i];
        
        if (elem.name == the_name) 
        {
            ret = elem;
            break;
        }
    }
    
    return ret;
}

function isSelection(the_element)
{
    if (the_element && the_element.type.indexOf("select") == 0)
    {
        return true;
    }
    
    return false;
}

function countSelectedOptions(the_element)
{
    var count = 0;
    
    for (var i = 0; i < the_element.options.length; i++)
    {
        if (the_element.options[i].selected)
        {
            count++;
        }
    }
    
    return count;
}

function toggleServerAction(chkbox, not_chk_action, chk_action)
{
    the_form = chkbox.form;
    
    if (chkbox.checked)
    {        
        the_form.server_action.value = chk_action;
    }
    else
    {
        the_form.server_action.value = not_chk_action;
    }
}