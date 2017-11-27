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

cat "common/publications-header.html"

LIST=`ls -w1 publications | sort -n -r` || fail "Could not find publications year directories at publications/"

for i in $LIST; do

    DIR="publications/$i"

    [ -d "$DIR"  ] || fail "$DIR is not a valid publications directory"

    if ls ${DIR}/*.info > /dev/null; then

	echo "<div class=\"row\">"
	echo "<h3 class=\"page-header\">$i</h3>"
	for p in $DIR/*.info; do
	    echo "  <p>"
	    cat $p
	    echo "  </p>"
	done
	echo "</div>"
    fi
done

cat "common/publications-footer.html"

