OUTPUT="$1"

function fail
{
    echo "FAIL: $1"
    exit 1
}


function gen_card {
    FILE="$1"
    D=`dirname $FILE`
    B=`basename $FILE .info`
    IMG="$D/$B" >> "${FILE}"

    cp ${IMG} ../img-people/${B} || fail "Could not copy ${IMG} to ../img-people/${B}"

   echo "  <div class=\"col-sm-4\">" 
   echo "    <table class=\"table\">"
   echo "      <tbody>"
   echo "	<tr>"
   echo "	  <td style=\"background:rgb(240,240,240);height:100px;width:90px\">"

   if [ ! -f ${IMG} ]; then
       echo "No Image"
   else
       echo "	    <img src=\"img-people/$B\" height=\"100px\" class=\"img-rounded\"/>"
   fi

   echo "	  </td>"
   echo "	  <td style=\"vertical-align:middle; background:rgb(240,240,240)\">"
   NAME=`grep NAME ${FILE} | cut -d: -f2-`
   WEB=`grep WEB ${FILE} | cut -d: -f2-`
   TITLE=`grep JOB ${FILE} | cut -d: -f2-`
   EMAIL=`grep EMAIL ${FILE} | cut -d: -f2-`
   if [ -z "$WEB" ]; then
       echo "	    $NAME"
   else
       echo "	    <a href=\"$WEB\" target=\"blank\">$NAME</a>"
   fi

   echo "            </br>$TITLE"

#    if [ ! `convert -gravity center -background transparent -fill black -size 180x35  label:"$EMAIL" mail.gif` ]; then
#        if [ ! `cp mail.gif ../img-people/${B}.mail.gif` ]; then
# 	   echo "            </br><img src=\"./img-people/${B}.mail.gif\"/>"
#        else
# 	   echo "            </br>$EMAIL"
#        fi
#    else
       echo "            </br>$EMAIL"
#   fi
   echo "	  </td>"
   echo "	</tr>"
   echo "      </tbody>"
   echo "      </table>"
   echo "  </div>"

}

if ls alumni/students-phd/*.info &> /dev/null; then
  echo "<div class=\"row\">"
  echo "<h3 class=\"page-header\">Ph.D. Students</h3>"
  for i in alumni/students-phd/*.info; do
      [ -f $i ] || fail "$i is not a valid file"
      gen_card "$i"
  done
  echo "</div>"
fi

if ls alumni/students-msc/*.info  &> /dev/null; then
echo "<div class=\"row\">"
echo "<h3 class=\"page-header\">M.Sc. Students</h3>"
for i in alumni/students-msc/*.info; do
    [ -f $i ] || fail "$i is not a valid file"
    gen_card "$i"
done
echo "</div>"
fi

if ls alumni/students-undergrad/*.info  &> /dev/null; then
echo "<div class=\"row\">"
echo "<h3 class=\"page-header\">Undergraduate Students</h3>"
for i in alumni/students-undergrad/*.info; do
    [ -f $i ] || fail "$i is not a valid file"
    gen_card "$i"
done
echo "</div>"
fi

