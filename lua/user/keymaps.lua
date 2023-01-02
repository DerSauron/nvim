-- leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Window navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

nmap("<C-Up>", "<CMD>resize +2<CR>")
nmap("<C-Down>", "<CMD>resize -2<CR>")
nmap("<C-Left>", "<CMD>vertical resize +2<CR>")
nmap("<C-Right>", "<CMD>vertical resize -2<CR>")

-- Buffer navigation
nmap("<C-J>", "<CMD>bnext<CR>")
nmap("<C-K>", "<CMD>bprevious<CR>")
nmap("<Leader>q", "<CMD>Bwipeout<CR>")

-- Keep selection while indenting in visual mode
xmap("<", "<gv")
xmap(">", ">gv")
xmap("=", "=gv")

-- Move text up and down
nmap("<A-j>", "<CMD>m .+1<CR>==")
nmap("<A-k>", "<CMD>m .-2<CR>==")
xmap("<A-j>", "<CMD>m .+1<CR>==gv")
xmap("<A-k>", "<CMD>m .-2<CR>==gv")

xmap("p", "\"_dP") -- delete selection and paste
xmap("y", "\"\"ygv") -- Keep selection after yanking

-- Simpler clipboard access
xmap("<C-A-d>", "\"+d")
xmap("<C-A-y>", "\"+ygv")
xmap("<C-A-p>", "\"_d\"+P")
nmap("<C-A-d>", "\"+dd")
nmap("<C-A-y>", "\"+yy")
nmap("<C-A-p>", "\"+P")

-- commenting
nmap("<A-/>", "gcc")
xmap("<A-/>", "gc")

-- nvim tree
nmap("<Leader>e", "<CMD>NvimTreeToggle<CR>")
nmap("<Leader>fe", "<CMD>NvimTreeFindFile<CR>")

-- telescope
nmap("<Leader>sf", "<CMD>Telescope find_files<CR>")
nmap("<Leader>st", "<CMD>Telescope live_grep<CR>")
nmap("<Leader>sp", "<CMD>Telescope projects<CR>")
nmap("<Leader>sb", "<CMD>Telescope buffers<CR>")
nmap("<Leader>sd", "<CMD>Telescope diagnostics<CR>")

-- helper
nmap("<Leader>h", "<CMD>noh<CR>")
