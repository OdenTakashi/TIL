import { useContext } from 'react'
import { LoginContext } from '../context/loginContext'

export default function Header() {
  const {loginStatus, setLoginStatus} = useContext(LoginContext)

  function loginButton() {
    return loginStatus ? 'ログイン中' : '未ログイン'
  }

  return(
    <header className='mx-6 mt-6 flex justify-between'>
      <p className='text-indigo-900 font-serif text-xl'>Memo App</p>
      <button onClick={() => setLoginStatus(!loginStatus)} className='p-1 border border-zinc-500 bg-indigo-500 rounded text-white hover:bg-indigo-800'>{loginButton()}</button>
    </header>
  )
}
