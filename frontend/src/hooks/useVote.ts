import { useState, useEffect } from "react";

const useVote = (votetype: string, ds_name: string) => {
  const [vote, setVote] = useState(false);
  var initial = true;

  // http://localhost:3000/upvote?ds=demo-dataset
  var url = process.env.REACT_APP_API_BASE_URL;
  url += votetype == "upvote" ? "/upvote?ds=" : "/downvote?ds=";
  url += ds_name;

  useEffect(() => {
    initial = false;
    if (vote) fetch(url, { method: "POST" });
    if (!vote && !initial) fetch(url, { method: "DELETE" });
  }, [vote]);
  return [vote, setVote];
};

export default useVote;
