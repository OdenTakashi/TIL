export default function EditForm({isEditable, memoLists, updateMemo, handleEditMode, formContent, updateContent}) {
  const editingNumber = isEditable
  const memoPlaceholder = 'TODO: Today Task \n- Running \n- Coding'

  function saveMemo(number) {
    const element = document.getElementById('content')

    if (!element.value || !element.value.match(/\S/g)) {
      alert('Warning: Add Memo Content')
      return
    }

    const memos = number <= memoLists.length ? updatingMemo(number, element) : createMemo(number, element)

    updateMemo(memos)
    localStorage.setItem('memos', JSON.stringify(memos))
    handleEditMode()
  }

  function createMemo(number, element) {
    const memos = [...memoLists, {id: number, title: element.value.split(/\n/)[0], body: element.value}]
    return memos
  }

  function updatingMemo(number, element) {
    return memoLists.map((memo) => {
      if (memo.id === number) {
        return {id: editingNumber, title: element.value.split(/\n/)[0], body: element.value}
      } else {
        return memo
      }
    })
  }

  function deleteMemo() {
    if (memoLists.some((memo) => memo.id === editingNumber)) {
      const memos = memoLists.filter((memo) => memo.id !== editingNumber)
      updateMemo(memos)
      localStorage.setItem('memos', JSON.stringify(memos))
    }
    handleEditMode()
  }

  if(isEditable) {
    return (
      <div className='text-sm w-1/2 m-auto mt-6'>
        <div className='mx-auto w-1/2'>
          <textarea className='border rounded p-2' rows='10' cols='50' id='content' required placeholder={memoPlaceholder} value={formContent} onChange={(e) => updateContent(e.target.value)}></textarea>
          <div className='flex justify-end mt-3 m-auto'>
            <button className='w-1/3 h-10 bg-indigo-700 text-white border p-1 rounded hover:bg-indigo-800' onClick={() => saveMemo(editingNumber)}>保存</button>
            <button className='ml-3 p-1 rounded underline text-xs hover:no-underline' onClick={() => handleEditMode('')}>キャンセル</button>
            <button className='p-1 ml-3 rounded underline text-xs hover:no-underline' onClick={() => deleteMemo()}>削除</button>
          </div>
        </div>
      </div>
    )
  }
}
