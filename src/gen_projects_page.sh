OUTPUT="$1"

function fail
{
    echo "FAIL: $1"
    exit 1
}

function gen_card {
    FILE="$1"

   LOGO=`grep LOGO: ${FILE} | cut -d: -f2-`
   TITLE=`grep TITLE: ${FILE} | cut -d: -f2-`
   DESC=`grep DESC: ${FILE} | cut -d: -f2-`
        
    echo "        <div class=\"col-sm-12 col-md-12 col-lg-12 col-xl-12\"><table class=\"table\"><tbody>"
    
    echo "          <tr>"
    echo "	     <td style=\"vertical-align:middle;height:100px;width:90px\">"
    echo "            <img id=\"project_image\" src=\"${LOGO}\">"
    echo "	     </td>"
    echo "	     <td style=\"vertical-align:middle;\">"
    echo "	      <h4>${TITLE}<h4>"
    echo "	     </td>"
    echo "	    </tr>"
    echo "	    <tr>"
    echo "	     <td colspan=\"2\">"
    echo "             ${DESC}"
    echo "	     </td>"
    echo "	    </tr>"
    echo "        </tbody></table></div>"
}

cat "common/projects-header.html"

echo "<p><h2 class=\"page-header\">Ongoing Projects</h2></p>"
echo "<div class=\"row\">"

# List all ongoing projects
for i in $(ls -w1 projects/ongoing/*.info | sort -r); do 
    [ -f $i ] || fail "$i is not a valid file"
    gen_card "$i"
done

echo "</div> <!-- row -->"


echo "<p><h2 class=\"page-header\">Past Projects</h2></p>"
echo "<div class=\"row\">"

# List all past projects
# List all ongoing projects
for i in $(ls -w1 projects/past/*.info | sort -r); do 
    [ -f $i ] || fail "$i is not a valid file"
    gen_card "$i"
done

echo "</div> <!-- row -->"

cat "common/projects-footer.html"

