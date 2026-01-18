async function loadProfileInfo() {
  const res = await fetch("/me");
  const data = await res.json();

  if (!data.authenticated) {
    document.getElementById("profile_info").innerHTML = "Morate se prijaviti.";
    return;
  }

  const profile = document.getElementById("profile_info");

  profile.innerHTML = `
    <div><strong>Picture:</strong> ${data.user.picture ?? "Not provided"}</div>
    <div><strong>Nickname:</strong> ${data.user.nickname ?? "Not provided"}</div>
    <div><strong>Name:</strong> ${data.user.name ?? "Not provided"}</div>
    <div><strong>SID:</strong> ${data.user.sid ?? "Not provided"}</div>
    <div><strong>Updated At:</strong> ${data.user.updated_at ?? "Not provided"}</div>
    <div><strong>Email:</strong> ${data.user.email ?? "Not provided"}</div>
    <div><strong>Email Verified:</strong> ${data.user.email_verified ?? "Not provided"}</div>
    <div><strong>Sub:</strong> ${data.user.sub ?? "Not provided"}</div>
  `;
}

loadProfileInfo();