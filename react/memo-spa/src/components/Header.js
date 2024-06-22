export default function Header() {
  return(
    <header className='mx-6 mt-6 flex justify-between'>
      <p className='text-indigo-900 font-serif text-xl'>Memo App</p>
      <button className='p-1 border border-zinc-500 bg-indigo-500 rounded text-white hover:bg-indigo-800'>ログイン中</button>
    </header>
  )
}
