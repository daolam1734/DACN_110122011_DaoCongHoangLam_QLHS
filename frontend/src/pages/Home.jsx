import React, { useEffect } from 'react'
import { useNavigate } from 'react-router-dom'

export default function Home() {
  const navigate = useNavigate()

  useEffect(() => {
    const token = localStorage.getItem('token')
    if (!token) {
      navigate('/login', { replace: true })
      return
    }

    let user = {}
    try {
      user = JSON.parse(localStorage.getItem('user') || '{}')
    } catch (e) { user = {} }

    // Determine role and redirect accordingly
    // Support multiple common shapes: user.role (string) or user.roles (array)
    const role = user.role || (Array.isArray(user.roles) && user.roles[0]) || null

    // Example routing rules (adjust as needed):
    // - admin -> /dashboard
    // - staff -> /dashboard
    // - default -> /dashboard
    // If you have more pages, expand mapping here.
    if (role === 'admin') {
      navigate('/dashboard', { replace: true })
      return
    }

    if (role === 'staff') {
      navigate('/dashboard', { replace: true })
      return
    }

    // fallback
    navigate('/dashboard', { replace: true })
  }, [navigate])

  return (
    <div className="min-h-screen flex items-center justify-center">
      <div className="text-center">
        <h2 className="text-xl font-medium">Đang chuyển hướng...</h2>
        <p className="text-sm text-gray-500">Vui lòng chờ trong giây lát.</p>
      </div>
    </div>
  )
}
