const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:4000'

export async function login(username, password) {
  const res = await fetch(`${API_BASE}/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password })
  })
  if (!res.ok) {
    const body = await res.json().catch(() => ({}))
    const msg = body && body.error ? body.error : `HTTP ${res.status}`
    const e = new Error(msg)
    e.status = res.status
    throw e
  }
  return res.json()
}

export function getToken() { return localStorage.getItem('token') }
export function logout() { localStorage.removeItem('token'); localStorage.removeItem('user') }
