export default function EditForm({isEditable, memoLists, storeMemo, handleEditMode, formContent, handleFormContent}) {
  function saveMemo() {
    let serialNumber = setSerialNumber()

    storeMemo({serialNumber})
    debugger
    localStorage.setItem('memos', JSON.stringify(memoLists))

    handleEditMode()
  }

  function setSerialNumber() {
    return memoLists.length === 0 ? 1 : memoLists[memoLists.length - 1].id + 1
  }

  if(isEditable) {
    return (
      <div className='text-sm w-1/2 m-auto mt-6'>
        <textarea className='border' id='content' value={formContent} onChange={(e) => handleFormContent(e.target.value)}></textarea>
        <div>
          <button className='border' onClick={saveMemo}>Save</button>
        </div>
      </div>
    )
  }
}
