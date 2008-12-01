module Snowpea
  AmbiguousError = "<p>Oops! Something went wrong. Possible reasons for the this
                  could be:</p>
                  <ul>
                    <li>Podcast URL was not found or mistyped</li>
                    <li>The URL does not contain any sound files</li>
                  </ul>
                  <p>If you think this is a mistake,
                  <a href=\"http://snowpea.uservoice.com/\" onclick=\"this.blur(); try { UserVoice.PopIn.show(); return false; } catch(e){}\">let us know</a>
                  and we'll look into it!"
  MissingUrl     = "<p>Please enter a URL</p>"
  NoCasts        = "<p>Looks like we couldn't find anything to play. It's possible that:</p>
                  <ul>
                    <li>The podcast has only video. We don't currently play videos. Sorry!</li>
                    <li>The URL does not contain any sound files</li>
                  </ul>
                  <p>If you think this is a mistake,
                  <a href=\"http://snowpea.uservoice.com/\" onclick=\"this.blur(); try { UserVoice.PopIn.show(); return false; } catch(e){}\">let us know</a>
                  and we'll look into it!"
end